using Godot;
using System;

/// <summary>
/// Generic state class for StateMachine. 
/// </summary>
public partial class State : Node
{
    // Handling State changes
    public Action<State, string> TransitionEvent;

    /// <summary>
    /// The method that's called when first entering this state. 
    /// </summary>
    public virtual void Enter() {}
    
    /// <summary>
    /// The method that's called when exiting this state.
    /// </summary> 
    public virtual void Exit() {}

    /// <summary>
    /// Equivalent to _PhysicsProcess.
    /// </summary>
    /// <param name="delta">Time passed in seconds each frame.</param>
    public virtual void PhysicsProcess(double delta) {}

    /// <summary>
    /// Equivalent to _Process.
    /// </summary>
    /// <param name="delta">Time passed in seconds each frame.</param>
    public virtual void Process(double delta) {}
}
