using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerAttackSMB : StateMachineBehaviour
{
    public int index;

    Transform attackEffect;

    public override void OnStateEnter(Animator animator, AnimatorStateInfo animatorStateInfo, int layerIndex)
    {
        animator.transform.GetComponent<PlayerController>().ShowWeapon();

        //特效
        attackEffect = animator.transform.Find("Effect/attack" + index);
        attackEffect.gameObject.SetActive(false);//特效先隐藏
        attackEffect.gameObject.SetActive(true);//再显示
    }

    public override void OnStateExit(Animator animator, AnimatorStateInfo animatorStateInfo, int layerIndex)
    {
        animator.transform.GetComponent<PlayerController>().HideWeapon();
        attackEffect.gameObject.SetActive(false);//退出时隐藏
    }

}
