/*  Modelo para verificacion formal, incluye especificacion LTL.
    ISEL 2021 */

/* Especificacion ltl */
ltl switchOn {
    [] (button -> <> light)
}

ltl switchOff {
    [] ((deadline && (!button W !light)) -> <> !light)
}


/* FSM inputs (used for guards) */
int button;
int deadline;

/* FSM outputs */
int light;


/* Process that indicates FSM behavior */
active proctype fsm() {
    int state = 0;

    printf("Initial state: 0\n");
    printf("State = %d, button = %d, deadline = %d, light = %d\n", state, button, deadline, light)
    do
    :: if
        :: (state == 0)  -> atomic {
            if
            :: (button) -> light = 1; state = 1; button = 0; printf("(button) Transition from state 0 to state 1\n");
            fi
        }
        :: (state == 1) -> atomic {
            if
            :: (button) -> button = 0; deadline = 0; printf("(button) Transition from state 1 to state 1\n");
            :: (deadline && !button) -> state = 0; light = 0; deadline = 0; printf("(deadline && !button) Transition from state 1 to state 0\n");
            fi
        }
    fi;
    printf("State = %d, button = %d, deadline = %d, light = %d\n", state, button, deadline, light) 
    od
}

/* Process that changes inputs arbitrarily  */

active proctype environment(){
    do
    :: !button -> skip
    :: button = 1
    :: deadline = 1
    od
}