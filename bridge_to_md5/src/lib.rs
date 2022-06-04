use {
    md5::{Digest, Md5},
    once_cell::sync::Lazy,
    std::sync::Mutex,
};

static BUFFER: Lazy<Mutex<String>> = Lazy::new(|| Mutex::new(String::new()));

#[repr(C)]
pub struct B128 {
    s: [u8; 32],
}

/// # Safety
/// It's safe.
#[no_mangle]
pub unsafe extern "C" fn hasher_push_data(packet: &[u8; 32]) -> u32 {
    let mut ret: u32 = 0;
    if let Ok(mut b) = BUFFER.lock() {
        b.push_str(std::str::from_utf8_unchecked(packet));
        ret = b.len() as u32;
    }
    ret
}

/// # Safety
/// It's safe.
#[no_mangle]
pub unsafe extern "C" fn hasher_finalize_and_reset(buffer: &mut [u8; 32]) -> u32 {
    let mut ret: u32 = 0;
    if let Ok(mut b) = BUFFER.lock() {
        let trimmed = b
            .chars()
            .filter(|c| {
                ('0' <= *c && *c <= '9') || ('a' <= *c && *c <= 'z') || ('A' <= *c && *c <= 'Z')
            })
            .collect::<String>();
        let mut hasher = Md5::new();
        ret = trimmed.len() as u32;
        hasher.update(trimmed);
        let st = format!("{:x}", hasher.finalize());
        // assert_eq!(st.chars().count(), 32);
        for (i, c) in st.chars().enumerate() {
            buffer[i] = c as u8;
        }
        b.clear();
    }
    ret
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
            // println!("{}", std::str::from_utf8_unchecked(&b));
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
            // println!("{}", std::str::from_utf8_unchecked(&b));
            assert_eq!(
                std::str::from_utf8_unchecked(&b),
                "ced9fc52441937264674bca3f4ba7588"
            );
        }
    }
    #[test]
    fn it_works3() {
        let mut b = [0; 32];
        b[0] = b'a';
        b[1] = b'b';
        b[2] = b'c';
        b[3] = b'd';
        b[4] = b'e';
        b[5] = b'f';
        b[6] = b'g';
        b[7] = b'h';
        b[8] = b'h';
        b[9] = b'h';
        b[10] = b'i';
        b[11] = b'j';
        b[12] = b'k';
        b[13] = b'l';
        b[14] = b'm';
        b[15] = b'n';
        unsafe {
            hasher_push_data(&b);
            hasher_push_data(&b);
            hasher_push_data(&b);
            dbg!(&BUFFER.lock());
            hasher_finalize_and_reset(&mut b);
            println!("{}", std::str::from_utf8_unchecked(&b));
            assert_eq!(
                std::str::from_utf8_unchecked(&b),
                "54e5d32b5da897a3a1f1855139f1675f"
            );
        }
        // try again
        let mut c = [0; 32];
        c[0] = b'A';
        c[1] = b'B';
        c[2] = b'C';
        c[3] = b'0';
        c[4] = b'1';
        c[5] = b'2';
        c[6] = b'x';
        c[7] = b'y';
        unsafe {
            hasher_push_data(&c);
            hasher_push_data(&c);
            hasher_push_data(&c);
            hasher_finalize_and_reset(&mut c);
            println!("{}", std::str::from_utf8_unchecked(&c));
            assert_eq!(
                std::str::from_utf8_unchecked(&c),
                "a512d6dfac798e8e563ba4b78f300265"
            );
        }
    }
}
