using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class HPView : ViewBase
{

    public GameObject hpItemPrefab;

    //显示哪个Damagable的血量
    public Damagable damagable;

    private Toggle[] hps; 

    private IEnumerator Start()
    {
        //初始化数组
        hps = new Toggle[damagable.maxHp];

       yield return null;


        for(int i = 0; i < damagable.maxHp; i++)
        {
            //血量一个一个出
            yield return new WaitForSeconds(0.1f);

            //血量实例化到Hps结点下
            GameObject hpItem  = GameObject.Instantiate(hpItemPrefab, transform.Find("Hps"));
            hps[i] = hpItem.GetComponent<Toggle>();
        }
    }

    //受伤后需要更新血量界面
    public void UpdateHPView()
    {
        for(int i = 0; i < hps.Length; i++)
        {
            hps[i].isOn = i < damagable.CurrentHp;
        }
    }

}
