use md5::{Digest, Md5};

#[repr(C)]
pub struct B128 {
    s: [u8; 32],
}

/// # Safety
/// It's safe.
#[no_mangle]
pub unsafe extern "C" fn hash(buffer: &mut [u8; 32]) -> u32 {
    let trimmed = std::str::from_utf8(buffer)
        .unwrap()
        .chars()
        .filter(|c| {
            ('0' <= *c && *c <= '9') || ('a' <= *c && *c <= 'z') || ('A' <= *c && *c <= 'Z')
        })
        .collect::<String>();
    let mut hasher = Md5::new();
    hasher.update(trimmed);
    let st = format!("{:x}", hasher.finalize());
    // assert_eq!(st.chars().count(), 32);
    for (i, c) in st.chars().enumerate() {
        buffer[i] = c as u8;
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
        b[4] = b'-';
        b[5] = b'-';
        unsafe {
            hash(&mut b);
            println!("{}", std::str::from_utf8_unchecked(&b));
            assert_eq!(
                std::str::from_utf8_unchecked(&b),
                "577571be4de9dcce85a041ba0410f29f"
            );
        }
    }
    #[test]
    fn it_works2() {
        let mut b = [0; 32];
        b[0] = b'h';
        b[1] = b'i';
        b[2] = b'j';
        b[3] = b'k';
        b[4] = b'l';
        b[5] = b'-';
        unsafe {
            hash(&mut b);
            println!("{}", std::str::from_utf8_unchecked(&b));
            assert_eq!(
                std::str::from_utf8_unchecked(&b),
                "ced9fc52441937264674bca3f4ba7588"
            );
        }
    }
}
