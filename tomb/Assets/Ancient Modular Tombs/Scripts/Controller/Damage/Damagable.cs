using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;



[Serializable]
public class DamageEvent : UnityEvent<Damagable,DamageMessage> { }

public class Damagable : MonoBehaviour
{
    #region 字段
    public int maxHp;//最大血量
    private int hp;//当前血量

    public float invincibleTime = 0;//物体受伤以后会有一段无敌的时间
    private bool isInvincible = false; //是否处于无敌状态
    private float invincibleTimer = 0;//无敌状态计时

    public DamageEvent onHurt;
    public DamageEvent onDeath;
    public DamageEvent onReset;
    public DamageEvent onInvincibleTimeOut;//无敌时间结束事件
    #endregion

    #region 属性
    public int CurrentHp
    {
        get { return hp; }
    }

    //判断死活
    public bool IsAlive
    {
        get
        {
            return CurrentHp > 0;
        }
    }

    #endregion

    #region 生命周期

    private void Start()
    {
        hp = maxHp;
    }

    private void Update()
    {
        if (isInvincible)
        {
            invincibleTimer += Time.deltaTime;
            //时间到了
            if (invincibleTimer >= invincibleTime)
            {
                isInvincible = false;
                invincibleTimer = 0;
                onInvincibleTimeOut?.Invoke(this, null);
            }
        }
    }

    #endregion

    #region 方法

    public void OnDamage(DamageMessage data)
    {
        if (hp <= 0)
        {
            return;
        }

        //无敌状态不能受伤
        if (isInvincible)
        {
            return;
        }


        hp -= data.damage;

        isInvincible = true;

        if (hp <= 0)
        {
            //死亡
            onDeath?.Invoke(this, data);
        }
        else
        {
            //受伤
            onHurt?.Invoke(this, data);
        }

    }

    //玩家死亡之后可以复活，重置数据
    public void ResetDamage()
    {
        hp = maxHp;
        isInvincible = false;
        invincibleTimer = 0;
        onReset?.Invoke(this, null);
    }

    #endregion




}


