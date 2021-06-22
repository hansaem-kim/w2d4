def no_dupes?(arr)
    h = Hash.new(0)
    arr.each {|ele| h[ele] += 1}
    h.select {|k,v| v==1}.keys
end

def no_consecutive_repeats?(arr)
    (0...arr.length-1).each do |i|
        if arr[i] == arr[i+1]
            return false
        end
    end
    true
end

def char_indices(str)
    h = Hash.new {|h,k| h[k] = []}
    str.each_char.with_index do |char, i|
        h[char] << i 
    end
    h
end

def longest_streak(str)
    i=0
    j=1
    max = 0
    streak = []
    while i < str.length
        if str[i]==str[j]
            j+=1
        else
            if j-i >= max
                streak << str[i...j] 
                max = j-i
            end
            i+=1
            j=i+1
        end
    end
    streak[-1]
end

def bi_prime?(num)
    primes = (2..num).select {|n| prime?(n)}
    primes.each do |prime|
        if primes.include?(num/prime.to_f)
            return true
        end
    end
    false

end

def prime?(n)
    return false if n < 2
    (2...n).each do |factor|
        if n%factor == 0
            return false
        end
    end
    true     
end

def vigenere_cipher(message, keys)
    new_s = ""
    abc = ("a".."z").to_a
    message.each_char.with_index do |char, i|
        index = (abc.index(char)+keys[i%keys.length])%26
        new_s += abc[index]
    end
    new_s
end

def vowel_rotate(str)
    vowel_hold = []
    vowel_index = 0
    vowel_hold = str.split("").select{|char| "aeiou".include?(char)}
    str.each_char.with_index do |char, i|
        if "aeiou".include?(char)
            str[i] = vowel_hold[vowel_index-1]
            vowel_index += 1
        end
    end
    str
end

class String
    def select(&prc)
        prc ||= Proc.new {|ch| false}
        new_s = ""
        self.each_char do |char|
            if prc.call(char)
                new_s +=char
            end
        end
        new_s
    end

    def map!(&prc)
        self.each_char.with_index do |char, i|
            self[i] = prc.call(char,i)
        end
        self
    end
end

def multiply(a,b)
    if b==1
        return a 
    elsif b==-1
        return -a
    end

    if b>0
        a + multiply(a,b-1)
    else
        -a + multiply(a,b+1)
    end
end

def lucas_sequence(n)
    if n==0
        return []
    elsif n==1
        return [2]
    elsif n==2
        return [2,1]
    end

    seq = lucas_sequence(n-1)
    seq << seq[-1] + seq[-2]
end

def prime_factorization(num)
    return [num] if prime?(num)
    factors=[]
    divisor=0
    primes = (2...num).select {|n| prime?(n)}
    primes.each do |prime|
        if num%prime == 0
            factors = [prime]
            divisor = num/prime
        end
    end
    factors << prime_factorization(divisor)
    factors.flatten.sort
end

def prime_factorization2(num)
    (2...num).each do |divisor|
        if num%divisor == 0
            return prime_factorization2(divisor) + prime_factorization2(num/divisor)
        end
    end
    [num]
end
