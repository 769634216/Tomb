using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SwitchMaterial : MonoBehaviour
{
    public Material[] target;

    private Renderer render;

    private void Awake()
    {
        render = transform.GetComponent<Renderer>();

        if (render == null)
        {
            throw new System.Exception("未查询到render组件！");
        }
        
    }

    public void Switch()
    {
        render.materials = target;
    }


}
