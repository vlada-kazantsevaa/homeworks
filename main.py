# 2. Используя numpy создайте матрицу 7 на 7

matrix = np.random.randint(0, 100, (7, 7))
print(matrix)

# 3. NumPy: создайтие диагональную матрицу, где по главной диагонали идут числа от 1 до 5

matrix = np.diag(np.arange(1, 6))
print(matrix)

# 4. Напиши функцию, которая принимает матрицу и проверяет, является ли она единичной. В ответе возвращается True или False

def is_identity_matrix(matrix):

# проверяем, что матрица не пустая и является списком списков
    if not isinstance(matrix, list) or not matrix or not isinstance(matrix[0], list):
        return False
    rows = len(matrix)
    cols = len(matrix[0])

# единичная матрица должна быть квадратной
    if rows != cols:
        return False

 # проверяем элементы матрицы
    for i in range(rows):
        for j in range(cols):
            if i == j: # элементы на главной диагонали
                if matrix[i][j] != 1:
                    return False
            else: # элементы вне главной диагонали
                if matrix[i][j] != 0:
                    return False
    return True

matrix = np.diag(np.arange(1, 6))
print(f"матрица: {is_identity_matrix(matrix)}")

# меняю код чтобы можно было добавить ревьюера

print('как у вас дела?')
