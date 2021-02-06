using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BossDeathSMB : StateMachineBehaviour
{

    public override void OnStateEnter(Animator animator, AnimatorStateInfo animatorStateInfo, int layerIndex)
    {
        animator.transform.GetComponent<BoxCollider>().enabled = false;

        animator.transform.Find("Energy").gameObject.SetActive(false);
        animator.transform.Find("Energy").gameObject.SetActive(true);
    }

}
