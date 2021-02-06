using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;

public enum MoveType
{
    Once,
    Loop,
    PingPong

}

public enum PositionType
{
    World,
    Local
}

public class Move : MonoBehaviour
{
    public Vector3 startPosition;//开始的位置
    public Vector3 endPosition;//结束的位置

    public float time = 1;//移动的时间

    private float timer; //移动的计时
    private float percent;//移动的百分比

    private bool isMoving = false;//是否在移动中

    public MoveType moveType = MoveType.Once;
    public PositionType positionType = PositionType.Local;

    public UnityEvent onMoveEnd;

    public bool moveOnAwake = false;

    public float delayTime = 0;
    private float delayTimer = 0;

    private void Awake()
    {
        if (moveOnAwake)
        {
            StartMove();
        }
    }


    private void Update()
    {
        if (isMoving)
        {
            CaculateMove();
        }
        
    }

    public void StartMove()
    {
        isMoving = true;
        timer = 0;
    }

    private void CaculateMove()
    {
        //处于延迟时间内
        if(delayTimer < delayTime)
        {
            
            delayTimer += Time.deltaTime;
            return;
        }

        timer += Time.deltaTime / time;
        //percent = timer / time;

        switch (moveType)
        {
            case MoveType.Once:
                percent = Mathf.Clamp01(timer);//百分比限制在0到1之间
                break;

            case MoveType.Loop:
                percent = Mathf.Repeat(timer,1);//timer大于1时从0开始
                break;

            case MoveType.PingPong:
                percent = Mathf.PingPong(timer, 1);//timer大于1时从1返回
                break;
        }


        MoveExcute();
        

        if( timer >= 1 && moveType == MoveType.Once)
        {
            isMoving = false;
            timer = 0;

            onMoveEnd?.Invoke();
        }

    }

    private void MoveExcute()
    {
        switch (positionType)
        {
            case PositionType.World:
                transform.position = Vector3.Lerp(startPosition, endPosition, percent);
                break;

            case PositionType.Local:
                transform.localPosition = Vector3.Lerp(startPosition, endPosition, percent);
                break;
        }
    }
}
