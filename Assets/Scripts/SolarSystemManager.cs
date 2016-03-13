using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class SolarSystemManager : MonoBehaviour {

    List<SpaceObject> planets;
    public SpaceObject sun;

    float G = 0.000667f;

    // Use this for initialization
    void Start () {
        planets = new List<SpaceObject>(GetComponentsInChildren<SpaceObject>());
        InitSolarSystem();
	}
	
    void InitSolarSystem()
    {
        for (int i = 0; i < planets.Count; i++)
        {
            if (planets[i].ObjectType != ESpaceObjectType.STAR)
            {
                float vx = 0;
                float vy = (Mathf.Sqrt(G * planets[i].mass / Vector3.Distance(sun.transform.position, planets[i].transform.position)));
                if(planets[i].transform.position.x > 0)
                {
                    vy = -vy;
                }
                planets[i].SetVelocity(vx, vy);
            }
        }
    }


    void Update()
    {
        for (int p1 = 0; p1 < planets.Count; p1++)
        {
            planets[p1].SetAcceleration(0,0, 0);
            for (int p2 = 0; p2 < planets.Count; p2++)
            {
                if (p1 != p2 && planets[p2].ObjectType != ESpaceObjectType.STAR)
                {
                    Vector3 delta = planets[p2].transform.position - planets[p1].transform.position;
                    float D = Mathf.Sqrt(Mathf.Pow(delta.x, 2) + Mathf.Pow(delta.z, 2) + Mathf.Pow(delta.y, 2));
                    float A = G * planets[p2].mass / Mathf.Pow(D, 2);
                    Vector3 oldA = planets[p1].GetAcceleration();
                    planets[p1].SetAcceleration(oldA + delta * A / D);
                }
            }
        }

        sun.UpdatePosition();
        Vector3 sunPosition = sun.transform.position;

        for (int p1 = 0; p1 < planets.Count; p1++)
        {
            if (planets[p1].ObjectType != ESpaceObjectType.STAR)
            {
                planets[p1].UpdatePosition();
            }
            planets[p1].transform.position -= sunPosition;
        }


    }


    // Update is called once per frame
    //void Update () {
    //       for (int i = 0; i < planets.Count; i++)
    //       {
    //           for (int j = 0; j < planets.Count; j++)
    //           {
    //               if (i != j && planets[j].ObjectType != ESpaceObjectType.STAR)
    //               {
    //                   float distance = Vector3.Distance(planets[i].transform.position, planets[j].transform.position);
    //                   if (distance != 0)
    //                   {
    //                       float force = MathLibrary.GravitationForce(planets[i].mass, planets[j].mass, distance);
    //                       planets[j].SetVelocity(planets[j].GetVelocity() + Vector3.Normalize(planets[i].transform.position - planets[j].transform.position) * force);
    //                   }
    //                   else
    //                   {
    //                       planets[j].SetVelocity(Vector3.zero);
    //                   }
    //               }
    //           }
    //       }
    //}
}
