module encrypt_unit(
    input [31:0] secret_key,
    input [31:0] plaintext,
    output [31:0] ciphertext
);

assign ciphertext= plaintext ^ secret_key; // xor encryption

endmodule

