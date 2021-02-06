using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[RequireComponent(typeof(AudioSource))]

public class RandomAudioPlayer : MonoBehaviour
{

    private AudioSource audioSource;
    public AudioClip[] defaultClips;


    private void Awake()
    {
        audioSource = transform.GetComponent<AudioSource>();
        if (audioSource==null)
        {
            throw new System.Exception("未查询到AudioSource");

        }

    }

    public void PlayRandomAudio()
    {
        int index = Random.Range(0, defaultClips.Length);
        audioSource.clip = defaultClips[index];
        audioSource.Play();
    }

}
