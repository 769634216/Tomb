using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[RequireComponent(typeof(Rigidbody))]
public class Bullet : MonoBehaviour
{
    #region 字段
    
    protected Rigidbody mRigidbody;

    //子弹在空中飞行的时间
    public float time;

    //爆炸特效
    public GameObject explosionEffect;

    

    #endregion


    #region Unity生命周期
    protected virtual void Awake()
    {

        mRigidbody = transform.GetComponent<Rigidbody>();

    }
    #endregion


    #region  方法
    public virtual void Shot(Vector3 target, Vector3 direction)
    {
       
    }

    public virtual  void Attack()
    {
       
    }

    public virtual void Explosion()
    {
        if (explosionEffect != null)
        {
            GameObject explosion = GameObject.Instantiate(explosionEffect);
            explosion.transform.position = transform.position;
            Destroy(explosion, 1);

        }

        Destroy(gameObject, 0.2f);


    }
    #endregion
}
