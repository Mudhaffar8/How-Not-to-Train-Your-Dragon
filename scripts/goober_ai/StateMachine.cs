using Godot;
using System.Collections.Generic;

/// <summary>
/// General class for managing states within a node.
/// </summary>
public partial class StateMachine : Node 
{
    [Export] 
    public NodePath _initialState; 

    private State _currentState; 
    private Dictionary<string, State> _states;

    /// <summary>
    /// Generates dictionary for states and runs initial state, if set.
    /// </summary>
    public override void _Ready() 
    {
        _states = new();
        
        // Add state nodes to states dictionary
        foreach (Node node in GetChildren()) 
        {
            if (node is State stateNode) 
            { 
                _states.Add(stateNode.Name.ToString().ToLower(), stateNode); 
                stateNode.TransitionEvent += OnTransition;
            }
        }

        // Set Current State to Initial state if initialized
        if (_initialState != null) 
        {
            _currentState = _states[_initialState.ToString().ToLower()];
            _currentState.Enter();
        }
    }


    public override void _PhysicsProcess(double delta)
    {
        _currentState?.PhysicsProcess(delta);
    }


    public override void _Process(double delta)
    {
        _currentState?.Process(delta);
    }

    /// <summary>
    /// Sets the newState as the current state and calls the Enter and Exit methods of the states.
    /// </summary>
    /// <param name="oldState">The current state.</param>
    /// <param name="newState">The state to transition to.</param>
    public void OnTransition(State oldState, string newState) 
    {
        newState = newState.ToLower();

        // Make sure the new state exists and is different from the old state
        if (!_states.ContainsKey(newState) || _states[newState] == oldState) 
            return;

        // Call enter and exit functions
        // Set new state to the current state
        oldState.Exit();
        _currentState = _states[newState];
        _currentState.Enter();

        GD.Print($"Transitioning from {oldState.Name} to {newState}!"); // Debugging
    }
}