using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerController : MonoBehaviour
{
    public float maxMoveSpeed = 5;
    //当前移动速度，渐变效果，速度从小到大
    public  float moveSpeed = 0 ;

    public float jumpSpeed = 10;

    public float gravity = 20;

    //人物是否在地面上
    public bool isGrounded = true;

    //竖直方向上的速度
    private float verticalSpeed = 0;

    private CharacterController characterController;

    private PlayerInput playerInput;

    private Vector3 move;

    //人物应该朝着相机的方向走而不是自己的方向zou
    public Transform renderCamera;

    //旋转角速度
    //public float angerSpeed = 400;
    public float MaxAngleSpeed = 1200;
    public float MinAngleSpeed = 400;

    //人物加速度
    public float accelerateSpeed = 5;

    private Animator animator;

    private AnimatorStateInfo currentStateInfo;
    private AnimatorStateInfo nextStateInfo;

    public GameObject weapon;

    //玩家重置位置
    public Vector3 respawnPosition;

    public RandomAudioPlayer jumpPlayer;

    public RandomAudioPlayer attackPlayer;

    public AudioSource footStep;

    public AudioSource hurt_audio;

    #region 常量
    //死亡动画哈希值
    private int DeathHash = Animator.StringToHash("Dying");

    #endregion

    private void Awake()
    {
        //初始化,获取
        characterController = transform.GetComponent<CharacterController>();
        playerInput = transform.GetComponent<PlayerInput>();
        animator = transform.GetComponent<Animator>();
    }

    private void Update()
    {
        currentStateInfo = animator.GetCurrentAnimatorStateInfo(0);
        nextStateInfo = animator.GetCurrentAnimatorStateInfo(0);



        //CaculateMove();放到根运动中处理
        CaculateVerticalSpeed();
        CaculateForwardSpeed();
        CaculateRotation();

        animator.SetFloat("normalizedTime",Mathf.Repeat( currentStateInfo.normalizedTime,1));//动画循环播放时取值也是0到1

        animator.ResetTrigger("attack");//跳跃时点击攻击键不会攻击，但是落地后会，需要reset，让其跳跃下不会再攻击
        if (playerInput.Attack )
        {
            //Debug.Log("攻击");
            animator.SetTrigger("attack");
        }
    }
    
    //人物移动
     public void caculateMove()
    {
        /*float h = Input.GetAxis("Horizontal");
        float v = Input.GetAxis("Vertical");

        Vector3 move = new Vector3(h, 0, v);*/

        move.Set(playerInput.Move.x, 0, playerInput.Move.y);//需根注

        move *= Time.deltaTime * moveSpeed;//需根注，因为移动速度根据动画来决定

        //转换方向，相机
        move = renderCamera.TransformDirection(move);

        //需根注
        if(move.x !=0 || move.y != 0)
        {
            //如果Y有值，人物会倾斜
            move.y = 0;

            //改变方向时直接转
           // transform.rotation = Quaternion.LookRotation(move);

            /*改变方向时人物慢慢旋转过去，优化旋转角速度需要改
            transform.rotation = Quaternion.RotateTowards(transform.rotation, Quaternion.LookRotation(move), angerSpeed*Time.deltaTime);*/
        }

        //加上竖直方向的移动速度
        move += Vector3.up * verticalSpeed * Time.deltaTime;

        characterController.Move(move);
        isGrounded = characterController.isGrounded;

        animator.SetBool("isGrounded", isGrounded);

        
    }

    //根运动的人物移动
    private void CaculateMove()
    {
        if (isGrounded)
        {
            //当前动画相对于上一帧动画的偏移
            move = animator.deltaPosition;
        }
        else
        {
            //在空中，跳跃时要向前移动
            move = moveSpeed * transform.forward * Time.deltaTime;
        }

       


        move += Vector3.up * verticalSpeed * Time.deltaTime;

        characterController.Move(move);
        isGrounded = characterController.isGrounded;

        animator.SetBool("isGrounded", isGrounded);

    }

    //使用根运动来让人物移动
    private void OnAnimatorMove()
    {
        CaculateMove();
        
    }


    //根运动的旋转方向
    private void CaculateRotation()
    {
        if(playerInput.Move.x != 0 || playerInput.Move.y != 0)
        {
            Vector3 targetDirection = renderCamera.TransformDirection(new Vector3(playerInput.Move.x, 0, playerInput.Move.y));
            targetDirection.y = 0;

            //旋转优化
            //速度越小，取值越靠近max，旋转速度越大
            float turnSpeed = Mathf.Lerp(MaxAngleSpeed, MinAngleSpeed, moveSpeed / maxMoveSpeed) * Time.deltaTime;
            transform.rotation = Quaternion.RotateTowards(transform.rotation, Quaternion.LookRotation(targetDirection),turnSpeed );
        }
    }

    //模拟重力，计算竖直方向的速度
    private void CaculateVerticalSpeed()
    {
        if (isGrounded)
        {
            verticalSpeed = -gravity * 0.3f;
            if (playerInput.Jump)//Input.GetKeyDown(KeyCode.Space)
            {
                verticalSpeed = jumpSpeed;
                isGrounded = false;

                jumpPlayer.PlayRandomAudio();
            }
        }
        else
        {
            //如果在空中上升时且没有按下空格键，则减两次速度使速度减得快，跳得就不高
            if(!playerInput.Jump && verticalSpeed > 0)
            {
                verticalSpeed -= gravity * Time.deltaTime;
            }

            //在空中，让速度慢慢减小到0，上升到下降
            verticalSpeed -= gravity * Time.deltaTime;
        }

    }

    //计算向前速度
    private void CaculateForwardSpeed()
    {
        moveSpeed = Mathf.MoveTowards(moveSpeed, maxMoveSpeed * playerInput.Move.normalized.magnitude, accelerateSpeed * Time.deltaTime);
        animator.SetFloat("forwardSpeed", moveSpeed);


    }

    public void ShowWeapon()
    {
        CancelInvoke("HideWeaponExcute");
        weapon.SetActive(true);
    }

    public void HideWeapon()
    {
        Invoke("HideWeaponExcute", 2f);//延时一秒后调用，即不会立即隐藏，如果在一秒之内又调用显示则取消调用，不会隐藏
    }

    private void HideWeaponExcute()
    {
        weapon.SetActive(false);
    }

    public void OnHurt(Damagable damagable , DamageMessage data)
    {
        Vector3 direction = data.damagePosition - transform.position;
        direction.y = 0;
        transform.rotation = Quaternion.LookRotation(direction);//朝向攻击目标
       /* Vector3 localDirection = transform.InverseTransformDirection(direction);
        animator.SetFloat("HurtX", localDirection.x);
        animator.SetFloat("HurtY", localDirection.y);*/



        //判断是不是需要重置位置
        if (data.isRestPosition)
        {
            //失去控制
            playerInput.ReleaseControl();

            //播放死亡动画
            animator.SetTrigger("death");

            //重置位置
            StartCoroutine(ResetPosition());

        }
        else
        {
            //不需要重置位置时才需要播放受伤东湖
            animator.SetTrigger("hurt");
        }

    }

    public void OnDeath(Damagable damagable , DamageMessage data)
    {
        animator.SetTrigger("death");

        StartCoroutine(Respawn());
    }

    //重置位置协程
    public IEnumerator ResetPosition()
    {
        // 判断是不是正在播放死亡动画，不是时就等一等
        while (currentStateInfo.shortNameHash != DeathHash)
        {
            yield return null;
        }

        yield return new WaitForSeconds(2f);

        //屏幕变黑
        yield return StartCoroutine(BlackMaskView.Instance.FadeOut());


        //重置玩家位置
        transform.position = respawnPosition;

        //播放对应重生动画
        animator.SetTrigger("respawn");

        //可能屏幕变亮还没播放重生动画
        yield return new WaitForSeconds(1f);

        //屏幕变亮
        yield return StartCoroutine(BlackMaskView.Instance.FadeIn());


        //给玩家控制权
        playerInput.GainControl();
    }



    //重生协程
    public IEnumerator Respawn()
    {
        yield return StartCoroutine(ResetPosition());

        //重置血量
        transform.GetComponent<Damagable>().ResetDamage();

       
    }


    //更新出生点
    public void SetRespawnPosition(Vector3 position)
    {
        respawnPosition = position;
    }


    #region AnimationEvents

    public void MeleeAttackStart()
    {
        weapon.GetComponent<WeaponAttackController>().BeginAttack();

        attackPlayer.PlayRandomAudio();
    }


    public void MeleeAttackEnd()
    {
        weapon.GetComponent<WeaponAttackController>().EndAttack();
    }

    public void InstantiateEffectStart()
    {
        weapon.GetComponent<WeaponAttackController>().BeginAttack();
    }

    public void InstantiateEffectEnd()
    {
        weapon.GetComponent<WeaponAttackController>().EndAttack();
    }

    public void InstantiateStart()
    {
        weapon.GetComponent<WeaponAttackController>().BeginAttack();
    }

    public void InstantiateEnd()
    {
        weapon.GetComponent<WeaponAttackController>().EndAttack();
    }


    public void PlayStep()
    {
        footStep.Play();
    }

    public void PlayHurt()
    {

        hurt_audio.Play();
    }


    #endregion
}
