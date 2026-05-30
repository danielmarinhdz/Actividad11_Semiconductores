// Elaborado por: Daniel Octavio Marin Hernandez

// Se implementa un modulo con entradas tipo reg y salidas tipo wire

module semaforo_tb();

reg clk, reset;

reg verde, 
    amarillo, 
    rojo;

wire rojo_out, 
     amarillo_out, 
     verde_out;

semaforo DUT (
    .clk(clk), 
    .reset(reset), 
    .verde(verde), 
    .amarillo(amarillo), 
    .rojo(rojo), 
    .rojo_out(rojo_out), 
    .amarillo_out(amarillo_out), 
    .verde_out(verde_out)
);

always #5 clk = ~clk; // Generador de reloj (cada 5 segundos alterna entre 0 y 1)

initial 
begin
    // Se inicializan las señales de entrada
    clk = 0;
    reset = 0;

    verde = 0;
    amarillo = 0;
    rojo = 0;

    #20;
    reset = 1; 
    #20
    reset = 0;
    
    #100;

    // Prueba de transición Verde a Amarillo
    verde = 1; 
    amarillo = 0; 
    rojo = 0;
    #30;
    verde = 0; 
    amarillo = 1; 
    rojo = 0;
    #10;
    // Prueba de transición Amarillo a Rojo
    verde = 0; 
    amarillo = 0; 
    rojo = 1;
    #45; 
    // Prueba de transición Rojo a Verde
    verde = 1; 
    amarillo = 0; 
    rojo = 0;
    #30;
    $finish;

end


initial
begin
    $monitor("Cambios de estado en el semaforo");
end

initial // Se genera un archivo VCD para visualizar las señales en GTKWave
begin
    $dumpfile("semaforo_tb.vcd"); 
    $dumpvars(0, semaforo_tb);
end
endmodule