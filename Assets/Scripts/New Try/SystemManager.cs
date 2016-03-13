using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class SystemManager : Singleton<SystemManager> {

    public EForceComputationType forceComputationType = EForceComputationType.HANDMADE;

    public List<IGravityAffected> planets;
    public Rigidbody sun;

	// Use this for initialization
	void Awake () {
        sun = GameObject.FindGameObjectWithTag("Sun").GetComponent<Rigidbody>();
        planets = new List<IGravityAffected>();
        GameObject[] o = GameObject.FindGameObjectsWithTag("Planet");
        foreach (GameObject item in o)
        {
            planets.Add(item.GetComponent<IGravityAffected>());
        }
    }

}

public enum EForceComputationType
{
    RIGIDBODY,
    HANDMADE
}