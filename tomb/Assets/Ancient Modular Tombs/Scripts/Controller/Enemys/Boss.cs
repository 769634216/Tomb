using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Boss : EnemyBase
{
    #region 字段

    public float shortAttackDistance;

    //private int rangeAttackHash = Animator.StringToHash("attack_short");
    private int normalAttackHash = Animator.StringToHash("normalAttack");
    private int longAttackHash = Animator.StringToHash("attack_long");

    //当前动画信息
    private AnimatorStateInfo currentAnimatorInfo;

    //子弹预制体
    public GameObject bossBulletPrefab;

    //射击位置
    public Transform ShootPosition;

    public WeaponAttackController meleeAttackController;

    #endregion

    #region 生命周期

    protected override void Update()
    {
        base.Update();
        currentAnimatorInfo = animator.GetCurrentAnimatorStateInfo(0);
    }

    #endregion

    #region 方法

    public override void Attack()
    {
        base.Attack();

        if (/*currentAnimatorInfo.shortNameHash == rangeAttackHash ||*/ currentAnimatorInfo.shortNameHash == normalAttackHash || currentAnimatorInfo.shortNameHash == longAttackHash)
        {
            animator.ResetTrigger("attack");
            //animator.ResetTrigger("attack_range");
            animator.ResetTrigger("attack_short");

            return;
        }

        if (Vector3.Distance(transform.position, Target.transform.position) > shortAttackDistance)
        {
            ChangeDirection();
            //远距离攻击
            Debug.Log("发射子弹");
            animator.ResetTrigger("attack");
            animator.SetTrigger("attack");
        }
        else
        {
            /*
            //近距离攻击
            if (Vector3.Angle(transform.forward, Target.transform.position - transform.position) > 20)
            {
                //近距离范围攻击
                Debug.Log("近距离范围攻击");
                animator.ResetTrigger("attack_range");
                animator.SetTrigger("attack_range");

            }*/
            //else
            //{
                //近距离普通攻击
                Debug.Log("近距离普通攻击");
                animator.ResetTrigger("attack_short");
                animator.SetTrigger("attack_short");
           // }
        }

    }

   protected override void OnAnimatorMove()
    {
        //base.OnAnimatorMove();
    }
    
    //转弯
    //修改方向，瞄准
    public void ChangeDirection()
    {
        if (Target != null)
        {
            Vector3 direction = Target.transform.position - transform.position;
            direction.y = 0;
            transform.rotation = Quaternion.LookRotation(direction);
        }
    }


    public void Shot()
    {
        //创建子弹
        if (Target != null)
        {
            GameObject bullet = GameObject.Instantiate(bossBulletPrefab);
            bullet.transform.position = ShootPosition.position;
            bullet.GetComponent<Bossbullet>().Shot(Target.transform.position, transform.forward);

        }


    }
    public override void OnDeath(Damagable damagable, DamageMessage data)
    {
        base.OnDeath(damagable, data);

        //播放动画
        animator.SetTrigger("death");

        //销毁自己
        Destroy(gameObject, 6);
    }



    #endregion

    #region AnimationEvents

    public void MeleeAttackStart()
    {
        meleeAttackController.BeginAttack();
    }

    public void MeleeAttackEnd()
    {
        meleeAttackController.EndAttack();
    }

    #endregion

}
