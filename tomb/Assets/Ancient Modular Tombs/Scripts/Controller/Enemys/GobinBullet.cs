using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GobinBullet : Bullet
{

   protected override void Awake()
    {
        base.Awake();


        Destroy(gameObject, 3);
    }

    //boss子弹是落在玩家范围内爆炸，Gobin子弹是打到玩家身上
    public override void Shot(Vector3 target, Vector3 direction)
    {
        base.Shot(target, direction);

        target += Vector3.up * 0.5f;

        

        //重力加速度
        float g = Mathf.Abs( Physics.gravity.y);

        //竖直向上的初速度
        float v0 = 8;

        //上升到最高点所需的时间
        float t0 = v0 / g;

        //上升到最高点的高度
        float y0 = 0.5f * g * t0 * t0;

        
        float t = 0;

        if(transform.position.y + y0 > target.y)
        {
            //总高度
            float y = transform.position.y - target.y + y0;

            //总时间
            t = Mathf.Sqrt(y * 2 / g) + t0;
        }
        else
        {
            t = t0;
        }

       

        Vector3 transPos = transform.position;
        transPos.y = 0;
        target.y = 0;
        float speed = Vector3.Distance(transPos, target) / t;//没有方向

        Vector3 velocity = direction.normalized * speed + Vector3.up * v0;//有方向

        Debug.Log(transform.name);
        mRigidbody = transform.GetComponent<Rigidbody>();
        mRigidbody.isKinematic = false;
        mRigidbody.velocity = velocity;

        //Invoke("Attack", 1);

        transform.GetComponent<WeaponAttackController>().BeginAttack();

        

    }

    public override void Attack()
    {
        base.Attack();

        //transform.GetComponent<WeaponAttackController>().BeginAttack();

        Destroy(gameObject);
    }



}
