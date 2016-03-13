using UnityEngine;
using UnityEngine.EventSystems;
using System.Collections;
using System;

public class PlanetInteraction : MonoBehaviour, IPointerClickHandler
{

    public delegate void PlanetSelection(PlanetInteraction p);
    public static event PlanetSelection OnPlanetSelected;

    public Planet planet;
    public LineRenderer line;

    public void OnPointerClick(PointerEventData eventData)
    {
        OnPlanetSelected(this);
        Debug.Log("Click");
    }

    // Use this for initialization
    void Start () {
        planet = GetComponent<Planet>();
        line = GetComponent<LineRenderer>();
	}
	
	public void DrawVelocity()
    {
        line.SetPosition(0, transform.position);
        line.SetPosition(1, transform.position + planet.body.velocity);
    }

    public void ResetLine()
    {
        line.SetPosition(0, transform.position);
        line.SetPosition(1, transform.position);
    }
}
