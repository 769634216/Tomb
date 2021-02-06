using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

public class Gobin : Spider
{
    //敌人逃跑距离
    public float escapeDistance;

    //子弹预制体
    public GameObject bulletPrefab;

    public Transform BulletPos;


    public override void FollowTarget()
    {
        ListenerSpeed();


        //base.FollowTarget();


        if (Target != null)
        {
            try
            {

                //判断是否逃跑
                if (Vector3.Distance(transform.position, Target.transform.position) <= escapeDistance)
                {

                    //需要逃跑
                    Escape();
                    return;
                }

                //向目标移动
                MoveToTarget();

                //判断路径是否有效，能否到达(partic无法到达，invalid无效)
                if (meshAgent.pathStatus == NavMeshPathStatus.PathPartial || meshAgent.pathStatus == NavMeshPathStatus.PathInvalid)
                {
                    if (Vector3.Distance(transform.position, Target.transform.position) > attackDistance)
                    {
                        //大于攻击距离
                        //目标丢失
                        LoseTarget();
                        return;
                    }


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

    public void Escape()
    {
        Debug.Log("逃跑");
        animator.ResetTrigger("attack");
        meshAgent.isStopped = false;
        meshAgent.speed = moveSpeed;
        Vector3 target = transform.position + (transform.position - Target.transform.position).normalized;
        meshAgent.SetDestination(target);
    }


    /*protected override void OnAnimatorMove()
    {
        
    }*/

    public override void AttackBegin()
    {
        //创建子弹
        GameObject b = GameObject.Instantiate(bulletPrefab);
        b.transform.position = BulletPos.position;

        //b.transform.position = transform.Find("BulletPos").position;
        b.GetComponent<Bullet>().Shot(Target.transform.position, transform.forward);
    }

    public override void AttackEnd()
    {
        
    }

    public override void MoveToTarget()
    {
        base.MoveToTarget();

        if (Vector3.Distance(transform.position, Target.transform.position) <= attackDistance)
        {
            //在攻击范围之内，不需要再移动
            meshAgent.isStopped = true;
        }
        else
        {
            meshAgent.isStopped = false;
        }
    }

    protected override void OnDrawGizmosSelected()
    {
        base.OnDrawGizmosSelected();
        UnityEditor.Handles.color = new Color(Color.green.r, Color.green.g, Color.green.b, 0.2f);
        UnityEditor.Handles.DrawSolidArc(transform.position, Vector3.up, transform.forward, 360, escapeDistance);
    }



} 