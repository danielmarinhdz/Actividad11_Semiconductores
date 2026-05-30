// Elaborado por: Daniel Octavio Marin Hernandez


// Se implementa un modulo con entradas y salidas para controlar un semaforo con tres estados: verde, amarillo y rojo.
module semaforo (
    input clk, reset,   

    input   verde,
            amarillo,
            rojo,            

    output reg rojo_out,
    output reg amarillo_out,
    output reg verde_out
);

    // Se declaran los estados del semaforo como parametros (Luz verde, luz amarilla, luz roja)
    parameter  EDO_VERDE    = 2'b00,
               EDO_AMARILLO = 2'b01,
               EDO_ROJO     = 2'b10;

    // Se declaran los registros para almacenar el estado actual y el siguiente estado del semaforo
    reg [1:0] current_state, next_state;

    // Se define la logica para actualizar el estado actual del semaforo en cada flanco positivo del reloj o cuando se active el reset
    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= EDO_ROJO; // Por seguridad inicia en Rojo
        else
            current_state <= next_state; 
    end

    // Se define la logica  para determinar el siguiente estado del semaforo
    always @(*) 
    begin
        // Se inicializan las salidas en 0 por defecto
        rojo_out = 0;
        amarillo_out = 0;
        verde_out = 0;

        case (current_state)
            EDO_VERDE: 
            begin

                verde_out = 1; // Se enciende la salida del estado verde

                if (amarillo)
                    next_state = EDO_AMARILLO;   // De verde pasa a amarillo
                else
                    next_state = EDO_VERDE;     // Permanece en verde
            end
            EDO_AMARILLO: 
            begin
                amarillo_out = 1; // Se enciende la salida del estado amarillo

                if (rojo)
                    next_state = EDO_ROJO;     // De amarillo pasa a rojo
                else
                    next_state = EDO_AMARILLO; // Permanece en amarillo
            end
            EDO_ROJO: 
            begin
                rojo_out = 1; // Se enciende la salida del estado rojo

                if (verde)
                    next_state = EDO_VERDE;   // De rojo vuelve a verde
                else
                    next_state = EDO_ROJO;   // Permanece en rojo   
            end
            default: next_state = EDO_ROJO;
        endcase
    end

endmodule