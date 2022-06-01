use md5::{Digest, Md5};

#[repr(C)]
pub struct B128 {
    s: [u8; 32],
}

/// # Safety
/// It's safe.
#[no_mangle]
pub unsafe extern "C" fn hash(i: &B128) -> B128 {
    let mut hasher = Md5::new();
    let inp = std::str::from_utf8(&i.s).unwrap();
    let input = inp
        .chars()
        .filter(|c| ('0' <= *c && *c <= '9') || ('a' <= *c && *c <= 'f'))
        .collect::<String>();
    hasher.update(input);
    let st = format!("{:x}", hasher.finalize());
    assert_eq!(st.chars().count(), 32);
    let mut vec = [0; 32];
    for (i, c) in st.chars().enumerate() {
        vec[i] = c as u8;
    }
    B128 { s: vec }
}

#[cfg(test)]
mod tests {
    use super::*;
    #[test]
    fn it_works() {
        let mut b = B128 { s: [0; 32] };
        b.s[0] = b'a';
        b.s[1] = b'b';
        b.s[2] = b'c';
        b.s[3] = b'0';
        unsafe {
            println!("{}", std::str::from_utf8_unchecked(&hash(&b).s));
        }
    }
}
