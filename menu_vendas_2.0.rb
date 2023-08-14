@menu_produtos = [
{cod: 1, produto: 'salada', preco: 14.99}, 
{cod: 2, produto: 'fritas', preco: 24.99},
{cod: 3, produto: 'hamburguer', preco: 29.99},
{cod: 4, produto: 'bebida', preco: 10.90},
{cod: 5, produto: 'sobremesa', preco: 7.00}
]

@pedido = []
@total_pedido = 0

puts <<EOS
===================================
ACESSE NOSSO MENU E FAÇA SEU PEDIDO
===================================
EOS

def clear
    system("clear")
end

def show_menu
    i = 1  
    @menu_produtos.each do |list|
        puts "[#{i}] #{list[:produto].to_s.ljust(24, '.').capitalize}R$#{'%.2f' %list[:preco]}"
        i += 1
    end
end

def functions
    puts "Digite a função desejada: \n"
    puts "[A] Adicionar Item"
    puts "[C] Cancelar Item"
    puts "[R] Resumo Pedido"
    puts "[F] Finalizar Pedido"
    funcao = gets.chomp.upcase
    if funcao == "A" 
        clear
        show_menu       
        add_item(input_produto)        
        return functions
    elsif funcao == "C"
        clear
        remove_item
        return functions
    elsif funcao == "R"
        clear
        resume
        return functions
    elsif funcao == "F"
        finalize_order
    else
        clear
        puts "============================"
        puts "Função digitada inválida!!!"
        puts "============================"        
        functions
    end         
end

def input_produto
    puts "Digite o código do produto: "
    @cod = gets.chomp.to_i    
end

def add_item(cod_produto)     
    @menu_produtos.each do |item|
        if cod_produto == item[:cod]
            @pedido << item[:produto]
            @total_pedido = @total_pedido.to_f + item[:preco].to_f        
        end
        clear
    end 
    
    unless @menu_produtos.any? { |item| item[:cod] == cod_produto }
        clear
        puts "========================="
        puts "Código produto inválido!"
        puts "========================="
    end 
end

def remove_item
    if @pedido.empty?
        puts "=============================="
        puts "Não há ITEM lançado no pedido!"
        puts "=============================="
        return functions
    end        
    @pedido.each.with_index { |item_cancela, index| puts "#{index + 1} --- #{item_cancela.capitalize}" }    
    puts "Digite o NÚMERO do item que deseja CANCELAR: "
    index_delete = gets.chomp.to_i  
    item_deletado = @pedido.delete_at(index_delete - 1)    
    @menu_produtos.each do |item|               
        if item_deletado == item[:produto]                   
            @total_pedido = @total_pedido.to_f - item[:preco].to_f                   
        end    
    end 
    clear
end

def resume
    clear    
    puts "=" * 42
    puts "RESUMO DO PEDIDO: "
    puts "=" * 42
    @pedido.each.with_index{ |item, index| puts "#{index + 1} ----- #{item.capitalize}"}   
    puts "=" * 42    
    puts "TOTAL PEDIDO => R$ #{'%.2f' %@total_pedido}.\n\n"    
end

def finalize_order
    resume
    puts "Obrigado pela preferência. Volte Sempre!!!"
end

functions

