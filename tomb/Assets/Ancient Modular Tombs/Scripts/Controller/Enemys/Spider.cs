using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

public class Spider : EnemyBase
{
    //字段
    public WeaponAttackController weapon;

    protected override void Start()
    {
        base.Start();
        animator.Play("idle",0,UnityEngine.Random.Range(0f,1f));
    }

    public override void Attack()
    {
        ChangeDirection();
        base.Attack();
        animator.SetTrigger("attack");
    }

    //修改方向，瞄准
    public void ChangeDirection()
    {
        if(Target != null)
        {
            Vector3 direction = Target.transform.position - transform.position;
            direction.y = 0;
            transform.rotation = Quaternion.LookRotation(direction);
        }
    }

    public virtual void AttackBegin()
    {
        weapon.BeginAttack();
    }

    public virtual void AttackEnd()
    {
        weapon.EndAttack();
    }

    public override void OnDeath(Damagable damagable, DamageMessage data)
    {
        base.OnDeath(damagable, data);

       

        //丢失目标
        LoseTarget();


        //停止追踪
        meshAgent.isStopped = true;
        meshAgent.enabled = false;


        //播放死亡动画
        animator.SetTrigger("death");


        //添加一个力让它飞出去
        Vector3 force = transform.position - data.damagePosition;
        force.y = 0;

        mRigidbody.isKinematic = false;
        mRigidbody.AddForce(force.normalized * 8 + Vector3.up * 4, ForceMode.Impulse);


        //三秒之后销毁
        Destroy(gameObject,5);
    }
}
