use std::{ffi::CStr, os::raw::c_char};

#[no_mangle]
pub extern "C" fn rustfunc1(a: f64) -> f64 {
    a * 10.0
}

/// # Safety
/// Prubably it's safe.
#[no_mangle]
pub unsafe extern "C" fn rustfunc2(c_buf: *const c_char) -> f64 {
    let c_str: &CStr = CStr::from_ptr(c_buf);
    let str_slice: &str = c_str.to_str().unwrap();
    dbg!(str_slice);
    0.0
}

#[repr(C)]
pub struct B80 {
    a: [u8; 10],
}
/// # Safety
/// Prubably it's safe.
#[no_mangle]
pub unsafe extern "C" fn rustfunc3(buf: &mut B80) -> B80 {
    dbg!(buf.a[0]);
    B80 {
        a: [1, 2, 3, 0, 1, 2, 3, 0, 1, 2],
    }
}
