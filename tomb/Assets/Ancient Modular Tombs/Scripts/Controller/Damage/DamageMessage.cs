using System.Collections;
using System.Collections.Generic;
using UnityEngine;



    //因为DamageMessage想要同inspector面板进行设置，所以要加上可序列化的标签
    [System.Serializable]

    //结构
    public class DamageMessage
    {
        public int damage;

        public Vector3 damagePosition;

        public bool isRestPosition;//是否重置位置
    }

