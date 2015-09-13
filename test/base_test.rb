require 'test_helper'

describe Enum::Base do
  describe Side do
    describe '#token' do
      it 'returns defined token as string by symbol' do
        assert_equal 'left', Side.token(:left)
      end

      it 'returns defined token as string by string' do
        assert_equal 'left', Side.token('left')
      end

      it 'raises exception on getting not defined token on getting token as string' do
        assert_raises Enum::TokenNotFoundError do
          Side.token('invalid')
        end
      end

      it 'raises exception on getting not defined token on getting token as symbol' do
        assert_raises Enum::TokenNotFoundError do
          Side.token(:invalid)
        end
      end
    end

    describe '#all' do
      it 'returns the defined values in order of their definition' do
        assert_equal ['left', 'right', 'whole'], Side.all
      end
    end

    describe '#name' do
      it 'returns translation when the translation available on string argument' do
        assert_equal 'This is a left side', Side.name('left')
      end

      it 'returns translation when the translation available on symbol argument' do
        assert_equal 'This is a left side', Side.name(:left)
      end

      it 'returns translation missing text when the translation unavailable on string argument' do
        assert_equal 'translation missing: en.enum.Side.right', Side.name('right')
      end

      it 'returns translation missing text when the translation unavailable on symbol argument' do
        assert_equal 'translation missing: en.enum.Side.right', Side.name(:right)
      end
    end
  end

  describe NewSide do
    describe '#all' do
      it 'returns the parent tokens and itself tokens' do
        assert_equal ['left', 'right', 'whole', 'center'], NewSide.all
      end
    end

    describe '#token' do
      describe "has parent's tokens and itselves" do
        specify { assert_equal 'left', NewSide.token(:left) }
        specify { assert_equal 'right', NewSide.token(:right) }
        specify { assert_equal 'whole', NewSide.token(:whole) }
        specify { assert_equal 'center', NewSide.token(:center) }
        specify do
          assert_raises Enum::TokenNotFoundError do
            NewSide.token(:invalid)
          end
        end
        specify do
          assert_raises Enum::TokenNotFoundError do
            NewSide.token('invalid')
          end
        end
      end
    end

    describe '#name' do
      describe "has parent's translation and itself" do
        specify { assert_equal 'This is a left side', NewSide.name('left') }
        specify { assert_equal 'This is a left side', NewSide.name(:left) }
        specify { assert_equal 'translation missing: en.enum.NewSide.right', NewSide.name('right') }
        specify { assert_equal 'translation missing: en.enum.NewSide.right', NewSide.name(:right) }
      end
    end
  end
end