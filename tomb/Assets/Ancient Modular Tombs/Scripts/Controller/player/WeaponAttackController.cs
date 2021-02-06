using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;


//加上可序列的标签让数组显示出来
[Serializable]
//检测点（类）
public class CheckPoint
{
    public Transform point;
    public float radius;

}


public class WeaponAttackController : MonoBehaviour
{
    #region 字段
    public CheckPoint[] checkPoint;

    public Color color;

    //检测结果
    private RaycastHit[] results = new RaycastHit[10];

    //层级
    public LayerMask layerMask;

    private bool Attack = false;

    //伤害值
    public int damage =1;

    //玩家自己
    public GameObject mySelf;

    //攻击列表
    private List<GameObject> attackList = new List<GameObject>();

    //碰撞特效
    public GameObject hitPrefab;

    public UnityEvent onAttack;

    private DamageMessage data;

    #endregion

    #region Unity生命周期
    void Start()
    {

    }
    private void Awake()
    {
        
      

    }

    void Update()
    {
     


    CheckGameObject();
      
    }

    private void OnDrawGizmosSelected()
    {
        for (int i = 0; i < checkPoint.Length; i++)
        {
            Gizmos.color = color;

            //把点给画出来
            Gizmos.DrawSphere(checkPoint[i].point.position, checkPoint[i].radius);
        }
    }

    #endregion


    #region 方法
    public void BeginAttack()
    {
        Attack = true;
    }

    public void EndAttack()
    {
        Attack = false;
        attackList.Clear();//攻击结束，攻击列表需要清空
    }

    //检测敌人
    public void CheckGameObject()
    {
        //并不是每一帧都需要检测，只有当attack为true时才用
        if (!Attack) { return; }

        //检测其他物体
        // Physics.SphereCastNonAlloc()
        for (int i = 0; i < checkPoint.Length; i++)
        {
            //检测到的数量
            int count = Physics.SphereCastNonAlloc(checkPoint[i].point.position, checkPoint[i].radius, Vector3.forward, results, 0, layerMask.value);
            for (int j = 0; j < count; j++)
            {
                //Debug.Log("检测到敌人进行攻击：" + results[j].transform.name);
                if(CheckDamage(results[j].transform.gameObject))
                 {
                     if(hitPrefab != null)
                     {
                         //实例化一个特效
                         GameObject hit = GameObject.Instantiate(hitPrefab);

                         hit.transform.position = checkPoint[i].point.position;

                        //Destroy(hit, 2);

                     }
                 }
                //CheckDamage(results[j].transform.gameObject);
            }

        }
    }

    //对敌人造成伤害
    public bool CheckDamage(GameObject obj)
    {
        

    //判断游戏物体是不是有受伤的功能，有这个组件才能进行攻击
        Damagable damagable = obj.GetComponent<Damagable>();
        if (damagable == null) { return false; }

        //可能会检测到玩家本身
        if (obj == mySelf) { return false; }

        //不能对一个物体进行连续攻击
        if (attackList.Contains(obj)) { return false; }

        data = new DamageMessage();

        data.damage = damage;
        data.damagePosition = mySelf.transform.position;
        //data.isRestPosition = false;
        damagable.OnDamage(data);

        //攻击到敌人时触发
        onAttack?.Invoke();

        attackList.Add(obj);
        return true;

    }
  
    #endregion


}
