""" Testing data types for ndimage calls
"""

import numpy as np

from scipy import ndimage

from numpy.testing import (assert_array_almost_equal,
                           assert_array_equal)

from nose.tools import assert_true, assert_equal, assert_raises


def test_map_coordinates_dts():
    # check that ndimage accepts different data types for interpolation
    data = np.array([[4, 1, 3, 2],
                     [7, 6, 8, 5],
                     [3, 5, 3, 6]])
    shifted_data = np.array([[0, 0, 0, 0],
                             [0, 4, 1, 3],
                             [0, 7, 6, 8]])
    idx = np.indices(data.shape)
    dts = (np.uint8, np.uint16, np.uint32, np.uint64, np.int8, np.int16,
           np.int32, np.intp, np.int64, np.float32, np.float64)
    for order in range(0, 6):
        for data_dt in dts:
            these_data = data.astype(data_dt)
            for coord_dt in dts:
                # affine mapping
                mat = np.eye(2, dtype=coord_dt)
                off = np.zeros((2,), dtype=coord_dt)
                out = ndimage.affine_transform(these_data, mat, off)
                assert_array_almost_equal(these_data, out)
                # map coordinates
                coords_m1 = idx.astype(coord_dt) - 1
                coords_p10 = idx.astype(coord_dt) + 10
                out = ndimage.map_coordinates(these_data, coords_m1, order=order)
                assert_array_almost_equal(out, shifted_data)
                # check constant fill works
                out = ndimage.map_coordinates(these_data, coords_p10, order=order)
                assert_array_almost_equal(out, np.zeros((3,4)))
            # check shift and zoom
            out = ndimage.shift(these_data, 1)
            assert_array_almost_equal(out, shifted_data)
            out = ndimage.zoom(these_data, 1)
            assert_array_almost_equal(these_data, out)


def test_uint64_max():
    # Test interpolation respects uint64 max
    # Avoid the max of uint64 because it leads to odd interpolation artefacts
    big = 2**63-1
    arr = np.array([big, big, big], dtype=np.uint64)
    # Tests geometric transform (map_coordinates, affine_transform)
    inds = np.indices(arr.shape) - 0.1
    x = ndimage.map_coordinates(arr, inds, order=0)
    assert_equal(x[1], big)
    # Tests zoom / shift
    x = ndimage.shift(arr, 0.1, order=0)
    assert_equal(x[1], big)
