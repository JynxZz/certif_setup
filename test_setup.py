def test_pandas():
    try:
        print('Loading pandas...')
        import pandas as pd
        df = pd.DataFrame({'pandas': ['OK']})
        if df.shape == (1, 1):
            print('✅ pandas OK')
        else:
            print('❌ pandas test failed')
    except ImportError:
        print('❌ pandas not installed')
    except Exception as e:
        print(f'❌ pandas test failed: {e}')

def test_sklearn():
    try:
        print('Loading Scikit-learn...')
        from sklearn.decomposition import PCA
        pca = PCA()
        print('✅ Scikit-learn OK')
    except ImportError:
        print('❌ Scikit-learn not installed')
    except Exception as e:
        print(f'❌ Scikit-learn test failed: {e}')

def test_tensorflow():
    try:
        print('Loading TensorFlow...')
        from tensorflow.keras import Sequential, layers
        model = Sequential()
        model.add(layers.Dense(10, input_dim=4, activation='relu'))
        model.add(layers.Dense(1, activation='linear'))
        model.summary()
        print('✅ TensorFlow OK')
    except ImportError:
        print('❌ TensorFlow not installed')
    except Exception as e:
        print(f'❌ TensorFlow test failed: {e}')

def main():
    test_pandas()
    test_sklearn()
    test_tensorflow()

if __name__ == "__main__":
    main()
