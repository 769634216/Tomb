using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BossShortAttackSMB : StateMachineBehaviour
{

    public override void OnStateEnter(Animator animator, AnimatorStateInfo animatorStateInfo, int layerIndex)
    {
        animator.transform.Find("Hits").gameObject.SetActive(false);
        animator.transform.Find("Hits").gameObject.SetActive(true);
    }

}
