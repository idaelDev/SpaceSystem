using UnityEngine;
using System.Collections;

public class TimeScaler : MonoBehaviour {

    public float timeMult = 1f;

	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
        Time.timeScale = timeMult;
    }
}
