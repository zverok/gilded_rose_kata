class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each { update_item(_1) }
  end

  private

  def update_item(item)
    return if item.name == "Sulfuras, Hand of Ragnaros"

    change =
      case [item.name, item.sell_in]
      in ["Aged Brie", ..0]
        +2
      in ["Aged Brie", _]
        +1
      in ["Backstage passes to a TAFKAL80ETC concert", ..0]
        -item.quality
      in ["Backstage passes to a TAFKAL80ETC concert", ..5]
        +3
      in ["Backstage passes to a TAFKAL80ETC concert", ..10]
        +2
      in ["Backstage passes to a TAFKAL80ETC concert", _]
        +1
      in [/Conjured/, ..0]
        -4
      in [/Conjured/, _]
        -2
      in [_, ..0]
        -2
      in [_, _]
        -1
      end

    item.sell_in -= 1

    item.quality = (item.quality + change).clamp(0..50)
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
