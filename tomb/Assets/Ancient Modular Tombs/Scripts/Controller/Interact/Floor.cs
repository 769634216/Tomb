using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Floor : MonoBehaviour
{

    public DamageMessage damageMessage;

    public LayerMask LayerMask;

    private void OnTriggerEnter(Collider other)
    {
        //判断是不是对应的层级，=0不是，=1是对应层级
        if ((LayerMask.value & (1 << other.gameObject.layer) )== 0)
        {
            return;
        }

        //判断与地面接触的物体是否是可攻击的游戏物体
        Damagable damagable = other.gameObject.GetComponent<Damagable>();
        if (damagable != null)
        {
            damagable.OnDamage(damageMessage);

        }
    }

}
