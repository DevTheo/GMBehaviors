# GMBehaviors
GameMaker Behaviors Core Lib
An attempt to simplify the amount of script necessary to have commonly used game mechanism (like joysticks or keyboard movement or on screen joysticks)

Behaviors for GameMaker (WIP)

1. Add the stuff in scripts and the object underneath behavior_lib
2. IMPORTANT!: Set your object's parent to be obj_behavior_controller
3. IMPORTANT!: In your create event be sure to call the parent (using the DnD "Call the Inherited Event")
4. Call the Behavior constructor (at this point either GotoRoomOnClickBehavior or SimpleKeyboardMovementBehavior) in your create event (script code) using the appropriate params
5. Profit

Additional knowledge be sure always call the inherited event (right now only step and create are used but more may come)
