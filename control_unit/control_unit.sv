module alu (output logic PCSrc, MemWrite, ALUSrc, RegWrite,
            output logic [2:0] ALUControl, ImmSrc,
            output logic [1:0] ResultSrc,
            input logic [31:0] Instr,
            input logic Zero, Negative);

assign opcode = Instr[6:0];
assign funct3 = Instr[14:12];
assign funct7 = Instr[31:25];

assign MemWrite = (opcode == 7'b0100011 && funct3 == 3'h2) ? 1 : 0; // only sw needs MemWrite = 1
assign RegWrite = (opcode[5:0] == 6'b100011) ? 0 : 1;               // only sw, bew, bne, blt and bge need RegWrite = 0

always_comb begin
    case (opcode)
        7'b0110011: begin
            case (funct3)
                3'h0: begin
                    case (funct7)
                        7'h00:  // add
                        7'h20:  // sub
                    endcase
                end
                3'h6:           // or
                3'h7:           // and
                3'h1:           // sll
                3'h5:           // srl
                3'h2:           // slt
                default: 
            endcase
        end

        7'b0010011: begin
            case (funct3)
                3'h0:           // addi
                3'h6:           // ori
                3'h7:           // andi
                3'h1:           // slli
                3'h5:           // srli
                3'h2:           // slti
                default: 
            endcase
        end

        7'b0000011: begin       // lw

        end

        7'b0100011: begin       // sw

        end

        7'b1100011: begin
            case (funct3)
                3'h0:           // beq
                3'h1:           // bne
                3'h4:           // blt
                3'h5:           // bge
                default: 
            endcase
        end

        7'b1101111: begin       // jal

        end

        7'b1100111: begin       // jalr

        end

        7'b0110111: begin       // lui

        end
        
        
    endcase
end

endmodule