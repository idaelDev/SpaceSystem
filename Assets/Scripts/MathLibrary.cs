using UnityEngine;
using System;

public class MathLibrary{

    static float G = 0.0667384f;

	public static float GravitationForce(float mass1, float mass2, float distance)
    {
        return ((mass1 * mass2) / (distance * distance))*G;
    }

    public static float SattelisationMinimalSpeed(float mass, float distance)
    {
        float libSpeed = Mathf.Sqrt(G*2 * mass / distance);
        float minSpeed = Mathf.Sqrt(G*(mass) / distance);
        return minSpeed;// + (libSpeed); 
    }
}
