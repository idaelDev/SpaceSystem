using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class PlanetPoolManager : Singleton<PlanetPoolManager> {

    public int size;
    public GameObject planetTemplate;
    public Transform solarSystemTransform;
    List<GameObject> planetPool;

	// Use this for initialization
	void Start () {
        planetPool = new List<GameObject>(GameObject.FindGameObjectsWithTag("Planet"));
        if(planetPool.Count < size)
        {
            for (int i = 0; i < size - planetPool.Count; i++)
            {
                CreateObject();
            }
        }
        else
        {
            size = planetPool.Count;
        }
	}
	
	public void SpawnPlanet(Vector3 position, float mass)
    {
        GameObject g = null;
        for (int i = 0; i < planetPool.Count; i++)
        {
            if (!planetPool[i].activeInHierarchy)
            {
                g = planetPool[i];
                break;
            }
        }
        if(g == null)
        {
            g = CreateObject();
            size++;
        }

        g.SetActive(true);
        Planet p = g.GetComponent<Planet>();
        p.Init();
        p.body.mass = mass;
        p.transform.position = position;
        p.InitVelocity();
    }

    private GameObject CreateObject()
    {
        GameObject g = Instantiate(planetTemplate) as GameObject;
        g.SetActive(false);
        g.transform.SetParent(solarSystemTransform);
        planetPool.Add(g);
        return g;
    }
}
