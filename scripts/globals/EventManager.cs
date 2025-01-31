using System;

/// <summary>
/// Static class for managing signals globally.
/// Useful for "one-to-many" or "many-to-many" communication.
/// </summary>
/// <example>
/// Connecting to a signal. 
/// <code>
/// EventManager.TestEvent += AnotherFunction;
/// </code>
/// Emitting a signal.
/// <code>
/// EventManager.TestEvent?.Invoke(); // Insert parameters if there are any
/// </code>
/// </example>
/// <remarks>
/// Godot doesn't automatically disconnect from the event once a node leaves the scene tree.
/// To avoid errors, whenever you connect to a signal, you must manually disconnect.
/// <example>
/// Example:
/// <code>
/// public override void _ExitTree() 
/// { 
///     EventManager.TestEvent -= AnotherFunction;
/// }
/// </code>
/// </example>
/// </remarks>
public static class EventManager
{
    // Use Func if you need to return a value
    // First type is the return type, the following types are the parameter types
    // public static Func<int, int> IncrementEvent;

    // Use Action if you don't need to return a value
    public static Action TestEvent;

}