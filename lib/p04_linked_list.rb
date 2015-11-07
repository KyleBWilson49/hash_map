class Link
  attr_accessor :key, :val, :next

  def initialize(key = nil, val = nil, nxt = nil, prev = nil)
    @key, @val, @next, @previous = key, val, nxt, prev
  end

  def to_s
    "#{@key}, #{@val}"
  end
end

class LinkedList
  include Enumerable

  attr_reader :head, :tail

  def initialize
    @head = Link.new
    @tail = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head
  end

  def last
    return first if first.next.nil?
    child = first.next
    until child.next.nil?
      child = child.next
    end
    @tail = child
  end

  def empty?
    first.next.nil?
  end

  def get(key)
    current_link = @head
    until current_link.key == key || current_link.next.nil?
      current_link = current_link.next
    end
    return nil if current_link.key != key
    current_link.val
  end

  def include?(key)
    current_link = @head
    until current_link.key == key || current_link == last
      current_link = current_link.next
    end

    current_link.key == key ? true : false
  end

  def insert(key, val)
    last.next = Link.new(key, val, nil, @tail)
  end

  def remove(key)
    current_link = @head
    next_link = @head.next
    prev_link = nil
    if current_link.key == key #when we're removing head
      current_link = nil
      @head = next_link
    end

    until current_link.key == key #keeps iterating 'til we find a match
      prev_link = current_link
      current_link = current_link.next
      next_link = current_link.next
    end

    current_link = nil
    prev_link.next = next_link
  end

  def each
    current_link = first.next
    while current_link
      yield current_link
      current_link = current_link.next
    end
    self
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
