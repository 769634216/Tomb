using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

[RequireComponent(typeof(NavMeshAgent))]
[RequireComponent(typeof(Animator))]
[RequireComponent(typeof(Rigidbody))]
[RequireComponent(typeof(Damagable))]

public class EnemyBase : MonoBehaviour
{
    #region 字段
    //检测距离
    public float checkDistance;

    //最大高度差，超过这个高度差就不进行攻击
    public float maxHeightDiff;

    //视野范围，单边，超过这个范围不进行攻击
    [Range(0, 180)]
    public float lookAngle;

    //检测结果,最多为10个
    RaycastHit[] results = new RaycastHit[10];

    //追踪距离
    public float followDistance;

    //攻击距离
    public float attackDistance;

    //检测层级
    public LayerMask layerMask;

    //要攻击的目标
    public GameObject Target;

    protected NavMeshAgent meshAgent;

    //怪物初始位置
    protected Vector3 startPosition;

    protected Animator animator;

    public float runSpeed = 3;
    public float walkSpeed = 1;

    protected float moveSpeed = 0;

    protected Rigidbody mRigidbody;

    protected bool isCanAttack = true;

    //攻击时间间隔
    public float attackTime;

    //攻击时间计时
    private float attackTimer;

    protected Damagable damagable;

    #endregion

    #region Unity生命周期
    protected virtual void Start()
    {
        meshAgent = transform.GetComponent<NavMeshAgent>();
        startPosition = transform.position;
        animator = transform.GetComponent<Animator>();
        mRigidbody = transform.GetComponent<Rigidbody>();

        damagable = transform.GetComponent<Damagable>();
    }

    protected virtual void Update()
    {
        //判断自己是否活着
        if (!damagable.IsAlive)
        {
            return;
        }



        if(Target != null && Target.GetComponent<PlayerInput>() != null)
        {
            if(Target.GetComponent<PlayerInput>().IsHaveControl() == false && Target.GetComponent<Damagable>().IsAlive)
            {
                //攻击目标没有控制权，不能进行攻击
                animator.speed = 0;//如果已经攻击一半了，发现目标失去控制权，则使攻击动画暂停
                return;
            }
            else
            {
                //可以攻击
                animator.speed = 1;
            }
        }

        CheckTarget();
        FollowTarget();

        //如果当前不能进行攻击，需要对时间进行计时，如果时间到了，就可以进行攻击(攻击CD效果)
        if (!isCanAttack)
        {
            attackTimer += Time.deltaTime;
            if(attackTimer >= attackTime)
            {
                isCanAttack = true;
                attackTimer = 0;
            }
        }
    }

    //根运动
    //private
    protected virtual void OnAnimatorMove()
    {
        //通过刚体来移动就不会出现丢失碰撞的情况
        mRigidbody.MovePosition(transform.position + animator.deltaPosition);
        
    }

    //将监测的范围在编辑器中画出来
    protected virtual void OnDrawGizmosSelected()
    {
        //画出检查范围（0.4是透明度）
        Gizmos.color = new Color(Color.blue.r, Color.blue.g, Color.blue.b, 0.4f);
        Gizmos.DrawSphere(transform.position, checkDistance);

        //画出追踪范围
        Gizmos.color = new Color(Color.gray.r, Color.gray.g, Color.gray.b, 0.4f);
        Gizmos.DrawSphere(transform.position, followDistance);

        //画出攻击范围
        Gizmos.color = new Color(Color.red.r, Color.red.g, Color.red.b, 0.4f);
        Gizmos.DrawSphere(transform.position, attackDistance);

        //画出高度差
        Gizmos.color = Color.red;
        Gizmos.DrawLine(transform.position, transform.position + Vector3.up * maxHeightDiff);
        Gizmos.DrawLine(transform.position, transform.position - Vector3.up * maxHeightDiff);

        //画出视野范围
        UnityEditor.Handles.color = new Color(Color.yellow.r, Color.yellow.g, Color.yellow.b, 0.4f);
        UnityEditor.Handles.DrawSolidArc(transform.position, Vector3.up, transform.forward, lookAngle, checkDistance);
        UnityEditor.Handles.DrawSolidArc(transform.position, -Vector3.up, transform.forward, lookAngle, checkDistance);
    }

    #endregion

    #region 方法
    //检测攻击目标
    public virtual void CheckTarget()
    {
        int count = Physics.SphereCastNonAlloc(transform.position, checkDistance, Vector3.forward, results, 0, layerMask.value);
        for (int i = 0; i < count; i++)
        {
            //判断是否为可攻击的游戏物体
            if (results[i].transform.GetComponent<Damagable>() == null) { continue; }

            //判断高度差
            if (Mathf.Abs(results[i].transform.position.y - transform.position.y) > maxHeightDiff) { continue; }

            //判断是否在视野范围内,目标物体的位置减去自身位置得到一个向量
            if (Vector3.Angle(transform.forward, results[i].transform.position - transform.position) > lookAngle) { continue; }

            //判断目标是不是活着的状态
            if (!results[i].transform.GetComponent<Damagable>().IsAlive) { continue; }

            //前面都满足了，则找到目标，选择一个最近的进行攻击
            if (Target != null)
            {
                //判断距离
                float distance = Vector3.Distance(transform.position, Target.transform.position);
                float currentDistance = Vector3.Distance(transform.position, results[i].transform.position);
                if (currentDistance < distance)
                {
                    Target = results[i].transform.gameObject;
                }
            }
            else
            {
                Target = results[i].transform.gameObject;
            }

        }
    }

    //向目标移动
    public virtual void MoveToTarget()
    {
        if (Target != null && transform.GetComponent<Damagable>().IsAlive)
        {
            meshAgent.SetDestination(Target.transform.position);
        }
    }

    //追踪目标
    public virtual void FollowTarget()
    {
        //跟踪目标时需要监听速度
        ListenerSpeed();

        if (Target != null)
        {
            try
            {
                //向目标移动
                MoveToTarget();

                //判断路径是否有效，能否到达(partic无法到达，invalid无效)
                if (meshAgent.pathStatus == NavMeshPathStatus.PathPartial || meshAgent.pathStatus == NavMeshPathStatus.PathInvalid)
                {
                    //目标丢失
                    LoseTarget();
                    return;
                }

                //是否在可追踪的距离内
                if (Vector3.Distance(transform.position, Target.transform.position) > followDistance)
                {
                    //目标丢失
                    LoseTarget();
                    return;
                }

                //判断目标是否还活着
                if (!Target.transform.GetComponent<Damagable>().IsAlive)
                {
                    LoseTarget();
                    return;
                }

                //判断是不是在攻击范围内
                if (Vector3.Distance(transform.position, Target.transform.position) <= attackDistance)
                {
                    //Debug.Log("进行攻击");
                    if (isCanAttack)
                    {
                        Attack();
                        isCanAttack = false;

                    }
                    
                }
            }
            catch (Exception e)
            {
                //追踪出错 目标丢失
                LoseTarget();

            }



        }
    }

    //目标丢失
    public virtual void LoseTarget()
    {
        Target = null;
        //活着的话回到初始位置
        if (transform.GetComponent<Damagable>().IsAlive)
        {
            meshAgent.SetDestination(startPosition);
            moveSpeed = walkSpeed;
        }
        
    }

    //速度监听
    public virtual void ListenerSpeed()
    {
        if (Target != null)
        {
            moveSpeed = runSpeed;
        }

        meshAgent.speed = moveSpeed;

        animator.SetFloat("speed", meshAgent.velocity.magnitude);
    }

    public virtual void Attack()
    {

    }

    //死亡
    public virtual void OnDeath(Damagable damagable,DamageMessage data)
    {

    }

    #endregion
}
