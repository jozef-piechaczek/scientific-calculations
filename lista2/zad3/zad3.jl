# Lista 2: Zadanie 3
# Autor: Józef Piechaczek

include("hilb.jl")
include("matcond.jl")
using LinearAlgebra, Printf

c = Float64[1, 1e1, 1e3, 1e7, 1e12, 1e16]
n = Int[5, 10, 20]

gauss_elimination(A, b) = A\b
inversion(A, b) = inv(A)*b
error = (v_app, v_real) -> norm(v_app - v_real) / norm(v_real)

function get_result(A, n)
    x = [1 for i = 1:n]
    b = A*x
    res_inv = inversion(A, b)
    res_gau = gauss_elimination(A, b)
    # println(res_inv, res_gau)

    inv_err = error(res_inv, x)
    gau_err = error(res_gau, x)
    println("cond: $(cond(A)), rank: $(rank(A)), gauss_err: $(gau_err), inv_err: $(inv_err)")

    # for LATEX
    # print("$(rank(A)) & ")
    # @printf("%.6e & ", cond(A))
    # @printf("%.6e & ", gau_err)
    # @printf("%.6e", inv_err)
    # println("\\\\\n\\hline")
end

function zad3_hilbert() 
    for i in 2:20
        print("$(i)x$(i) & ")
        get_result(hilb(i), i)
    end
end

function zad3_cond()
    for i in c
        for j in n
            print("$(j)x$(j) & ")
            get_result(matcond(j, i), j)
        end
    end
end

zad3_hilbert()
print("\n------------\n\n")
zad3_cond()
