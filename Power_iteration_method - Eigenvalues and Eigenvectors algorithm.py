import numpy as np

def power_iteration(A, x0, n_iterations=100, tol=1e-6):
    """
    Calculate the dominant eigenvalue and eigenvector of a matrix using power iteration method.

    Parameters:
        A (ndarray): Input matrix.
        x0 (ndarray): Initial guess for the eigenvector.
        n_iterations (int): Maximum number of iterations.
        tol (float): Tolerance to determine convergence.

    Returns:
        eigenvalue (float): Approximated dominant eigenvalue.
        eigenvector (ndarray): Corresponding eigenvector.
    """
    x = x0 / np.linalg.norm(x0)  # Normalize initial guess

    for i in range(n_iterations):
        Ax = np.dot(A, x)
        eigenvalue = np.dot(x, Ax)
        new_x = Ax / np.linalg.norm(Ax)
        if np.linalg.norm(new_x - x) < tol:
            break
        x = new_x

    return eigenvalue, x

def deflate_matrix(A, eigenvalue, eigenvector):
    """
    Deflate the matrix A by subtracting the contribution of the dominant eigenpair.

    Parameters:
        A (ndarray): Input matrix.
        eigenvalue (float): Dominant eigenvalue.
        eigenvector (ndarray): Dominant eigenvector.

    Returns:
        A_deflated (ndarray): Deflated matrix.
    """
    A_deflated = A - eigenvalue * np.outer(eigenvector, eigenvector)
    return A_deflated

# Example matrix A
A = np.array([[-32,14,0], [18,-32,14],[0,18,-32]])

# Initial guess for eigenvector
x0 = np.array([1, 1, 1])

eigenvalue, eigenvector = power_iteration(A, x0)
print("Dominant eigenvalue:", eigenvalue)
print("Corresponding eigenvector:", eigenvector)

# Deflate the matrix A
A_deflated = deflate_matrix(A, eigenvalue, eigenvector)

# Find the next eigenvalue and eigenvector
eigenvalue2, eigenvector2 = power_iteration(A_deflated, x0)
print("Next eigenvalue:", eigenvalue2)
print("Corresponding eigenvector:", eigenvector2)

# Deflate the matrix A
A_deflated2 = deflate_matrix(A_deflated, eigenvalue2, eigenvector2)

# Find the third eigenvalue and eigenvector
eigenvalue3, eigenvector3 = power_iteration(A_deflated2, x0)
print("Next eigenvalue:", eigenvalue3)
print("Corresponding eigenvector:", eigenvector3)
