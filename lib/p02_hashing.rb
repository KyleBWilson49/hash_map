class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    hashed = 6000
    even = true
    self.each do |item|
      if even
        hashed *= item.hash * 2038
        even = false
      else
        hashed /= item.hash
        even = true
      end
    end
    hashed
  end
end

class String
  def hash
    hashed = 6000
    even = true
    self.split("").each do |letter|
      if even
        hashed *= letter.ord * 573
        even = false
      else
        hashed /= letter.ord
        even = true
      end
    end
    hashed
  end
end

class Hash
  def hash
    hashed = 1
    self.each do |key, val|
      hashed *= key.to_s.hash * val.to_s.hash
    end
    hashed
  end
end
