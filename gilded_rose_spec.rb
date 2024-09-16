require_relative 'gilded_rose'
require 'saharspec'
require 'saharspec/its/with'

describe GildedRose do
  before { days.times { gilded_rose.update_quality } }

  let(:gilded_rose) { GildedRose.new([item]) }

  alias_matcher :become, :have_attributes

  describe 'standard item' do
    subject(:item) { Item.new(name="+5 Dexterity Vest", sell_in=10, quality=20) }

    it_with(days: 1) { is_expected.to become(sell_in: 9, quality: 19) }
    it_with(days: 10) { is_expected.to become(sell_in: 0, quality: 10) }
    it_with(days: 11) { is_expected.to become(sell_in: -1, quality: 8) }
    it_with(days: 15) { is_expected.to become(sell_in: -5, quality: 0) }
  end

  describe 'aged brie' do
    subject(:item) { Item.new(name="Aged Brie", sell_in=2, quality=0) }

    it_with(days: 1) { is_expected.to become(sell_in: 1, quality: 1) }
    it_with(days: 5) { is_expected.to become(sell_in: -3, quality: 8) }
    it_with(days: 100) { is_expected.to become(sell_in: -98, quality: 50) }
  end

  describe 'backstage pass' do
    subject(:item) { Item.new(name="Backstage passes to a TAFKAL80ETC concert", sell_in=15, quality=20) }

    it_with(days: 1) { is_expected.to become(sell_in: 14, quality: 21) }
    it_with(days: 5) { is_expected.to become(sell_in: 10, quality: 25) }
    it_with(days: 10) { is_expected.to become(sell_in: 5, quality: 35) }
    it_with(days: 12) { is_expected.to become(sell_in: 3, quality: 41) }
    it_with(days: 15) { is_expected.to become(sell_in: 0, quality: 50) }
    it_with(days: 16) { is_expected.to become(sell_in: -1, quality: 0) }
  end

  describe 'legendary item' do
    subject(:item) { Item.new(name="Sulfuras, Hand of Ragnaros", sell_in=0, quality=80) }

    it_with(days: 1) { is_expected.to become(sell_in: 0, quality: 80) }
    it_with(days: 10) { is_expected.to become(sell_in: 0, quality: 80) }
    it_with(days: 100) { is_expected.to become(sell_in: 0, quality: 80) }
  end
end
