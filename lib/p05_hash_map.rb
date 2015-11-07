require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  include Enumerable

  attr_reader :count, :num_buckets

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
    @num_buckets = num_buckets
  end

  def include?(key)
    @store[key.hash % num_buckets].include?(key)
  end

  def set(key, val)
    resize! if count == num_buckets
    if include?(key)
      @store[key.hash % num_buckets].each do |link|
        link.val = val if link.key == key
      end
    else
      @store[key.hash % num_buckets].insert(key, val)
      @count += 1
    end
  end

  def get(key)
    @store[key.hash % num_buckets].get(key)
  end

  def delete(key)
    @store[key.hash % num_buckets].remove(key)
    @count -= 1
  end

  def each
    @store.each do |link_list|
      link_list.each do |link|
        link
      end
    end
    self
  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    new_set = Array.new(num_buckets * 2) { LinkedList.new }
    @store.each do |link_list|
      link_list.each do |link|
        new_set[link.key.hash % (num_buckets * 2)].insert(link.key, link.val)
      end
    end
    @store = new_set
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
  end
end
