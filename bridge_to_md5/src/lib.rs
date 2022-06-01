use md5::{Digest, Md5};

#[repr(C)]
pub struct B128 {
    s: [u8; 32],
}

/// # Safety
/// It's safe.
#[no_mangle]
pub unsafe extern "C" fn hash(i: &mut [u8; 32]) -> u32 {
    let mut hasher = Md5::new();
    let inp = std::str::from_utf8(i).unwrap();
    let input = inp
        .chars()
        .filter(|c| ('0' <= *c && *c <= '9') || ('a' <= *c && *c <= 'f'))
        .collect::<String>();
    hasher.update(input);
    let st = format!("{:x}", hasher.finalize());
    assert_eq!(st.chars().count(), 32);
    for (ix, c) in st.chars().enumerate() {
        i[ix] = c as u8;
    }
    0u32
}

#[cfg(test)]
mod tests {
    use super::*;
    #[test]
    fn it_works() {
        let mut b = [0; 32];
        b[0] = b'a';
        b[1] = b'b';
        b[2] = b'c';
        b[3] = b'0';
        unsafe {
            hash(&mut b);
            println!("{}", std::str::from_utf8_unchecked(&b));
        }
    }
}
