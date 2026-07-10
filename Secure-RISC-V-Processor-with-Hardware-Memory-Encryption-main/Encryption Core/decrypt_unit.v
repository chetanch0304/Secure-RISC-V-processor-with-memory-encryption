module decrypt_unit(
    input [31:0] secret_key,
    input [31:0] ciphertext,
    output [31:0] plaintext
);

assign plaintext= ciphertext ^ secret_key; // xor decryption

endmodule

