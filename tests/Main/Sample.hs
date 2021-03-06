module Main.Sample where

import Rebase.Prelude
import Test.QuickCheck.Instances
import qualified VectorBuilder.Builder as A
import qualified Rebase.Data.Vector as B
import qualified Test.Tasty.QuickCheck as C


data Sample a =
  Empty |
  Singleton a |
  Vector (Vector a)
  deriving (Show)

toBuilder :: Sample a -> A.Builder a
toBuilder =
  \case
    Empty -> A.empty
    Singleton a -> A.singleton a
    Vector a -> A.vector a

toVector :: Sample a -> Vector a
toVector =
  \case
    Empty -> B.empty
    Singleton a -> B.singleton a
    Vector a -> a

instance C.Arbitrary a => C.Arbitrary (Sample a) where
  arbitrary =
    do
      constructorIndex <- C.choose (0 :: Int, 2)
      case constructorIndex of
        0 -> return Empty
        1 -> C.arbitrary >>= return . Singleton
        2 -> C.arbitrary >>= return . Vector
