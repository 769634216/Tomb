using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Bossbullet : Bullet
{
    


    public override void Shot(Vector3 target,Vector3 direction)
    {
        base.Shot(target,direction);
        //子弹飞出去时，需要受到力的影响
        mRigidbody.isKinematic = false;

        Vector3 toTarget = target - transform.position;
        toTarget.y = 0;
        float speed = toTarget.magnitude / time *2f;
        mRigidbody.velocity = direction.normalized * speed + Vector3.up * 3;

        Invoke("Attack", time);
    }

    public override void Attack()
    {

        base.Attack();
        //爆炸
        Explosion();

        //对人物攻击
        transform.GetComponent<WeaponAttackController>().BeginAttack();
    }

    
}
