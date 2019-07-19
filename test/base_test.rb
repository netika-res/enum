require 'test_helper'

describe Enum::Base do
  describe Side do
    describe '#indexes' do
      describe 'returns defined indexes' do
        specify { assert_equal [0, 1], Side.indexes }
      end
    end

    describe '#enums' do
      describe 'returns given tokens safely' do
        specify { assert_equal [{:left=>"my_left"}, {:right=>"my_right"}], Side.enums(:left, :right) }
        specify { assert_equal [{:left=>"my_left"}, {:right=>"my_right"}], Side.enums('left', :right) }
        specify { assert_equal [{:left=>"my_left"}, {:right=>"my_right"}], Side.enums(:left, 'right') }
        specify { assert_equal [{:left=>"my_left"}, {:right=>"my_right"}], Side.enums('left', 'right') }

        specify do
          assert_raises Enum::TokenNotFoundError do
            Side.enums(:left, :invalid)
          end
        end
      end
    end

    describe '#include?' do
      describe 'returns boolean result in any case' do
        specify { assert_equal true, Side.include?(:left) }
        specify { assert_equal true, Side.include?('left') }
        specify { assert_equal false, Side.include?(:invalid) }
      end
    end

    describe '#enum' do
      it 'returns defined token as hash by symbol' do
        assert_equal {:left=>"my_left"}, Side.enum(:left)
      end

      it 'returns defined token as hash by string' do
        assert_equal {:left=>"my_left"}, Side.enum('left')
      end

      it 'raises exception on getting not defined token on getting token by string' do
        assert_raises Enum::TokenNotFoundError do
          Side.enum('invalid')
        end
      end

      it 'raises exception on getting not defined token on getting token by symbol' do
        assert_raises Enum::TokenNotFoundError do
          Side.enum(:invalid)
        end
      end
    end

    describe '#all' do
      it 'returns the defined keys of hashes as symbols, in the order of their definition' do
        assert_equal [:left, :right], Side.all
      end
    end

    describe '#find_index' do
      describe 'returns index for given token' do
        specify { assert_equal 0, Side.index('left') }
        specify { assert_equal 0, Side.index(:left) }
        specify { assert_equal 1, Side.index('right') }
        specify { assert_equal 1, Side.index(:right) }
        specify do
          assert_raises Enum::TokenNotFoundError do
            Side.enum(:invalid)
          end
        end
        specify do
          assert_raises Enum::TokenNotFoundError do
            Side.enum('invalid')
          end
        end
      end
    end
  end

  describe NewSide do
    describe '#all' do
      it 'returns the parent tokens and itself tokens' do
        assert_equal [:left, :right, :center], NewSide.all
      end
    end

    describe '#enum' do
      describe "has parent's tokens and itselves" do
        specify { assert_equal {:left=>"my_left"}, NewSide.enum(:left) }
        specify { assert_equal {:right=>"my_right"}, NewSide.enum(:right) }
        specify { assert_equal {:center=>"my_center"}, NewSide.enum(:center) }
        specify do
          assert_raises Enum::TokenNotFoundError do
            NewSide.enum(:invalid)
          end
        end
        specify do
          assert_raises Enum::TokenNotFoundError do
            NewSide.enum('invalid')
          end
        end
      end
    end

    describe '#find_index' do
      describe 'returns index for given token' do
        specify { assert_equal 0, NewSide.index('left') }
        specify { assert_equal 0, NewSide.index(:left) }
        specify { assert_equal 1, NewSide.index('right') }
        specify { assert_equal 1, NewSide.index(:right) }
        specify { assert_equal 2, NewSide.index('center') }
        specify { assert_equal 2, NewSide.index(:center) }
        specify do
          assert_raises Enum::TokenNotFoundError do
            NewSide.enum(:invalid)
          end
        end
        specify do
          assert_raises Enum::TokenNotFoundError do
            NewSide.enum('invalid')
          end
        end
      end
    end
  end

  describe Room::COLORS do
    describe '#all' do
      it 'returns the defined values in order of their definition' do
        assert_equal [:yellow, :orange, :blue], Room::COLORS.all
      end
    end
  end
end
