require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count, :max
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map.include?(key)
      update_link!(@map[key])
    else
      value = calc!(key)
      @map.set(key, @store.insert(key, value))
    end

    eject! if count > max
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    @prc.call(key)
  end

  def update_link!(link)
    @store.insert(link.key, link.val)
    @store.remove(link.key)
    # suggested helper method; move a link to the end of the list
  end

  def eject!
    least_used_key = @store.first.next.key
    @store.remove(least_used_key)
    @map.delete(least_used_key)
  end
end
